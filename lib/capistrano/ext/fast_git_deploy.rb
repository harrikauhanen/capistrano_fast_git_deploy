Capistrano::Configuration.instance.load do
  set :scm,        :git
  set :branch,     "origin/master"
  set :migrate_target, :current
  set :use_sudo, false
  set :ssh_options, {:forward_agent => true}

  namespace :deploy do
    desc "Setup a fast git deployment."
    task :setup, :except => { :no_release => true } do
      dirs = [deploy_to, shared_path]
      dirs += shared_children.map { |d| File.join(shared_path, d) }
      run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
      run "git clone #{repository} #{current_path}"
    end

    task :default do
      update
    end

    task :update do
      transaction do
        update_code
      end
    end

    desc "Update the deployed code."
    task :update_code, :except => { :no_release => true } do
      run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
    end

    namespace :rollback do
      desc "Moves the repo back to the previous version of HEAD"
      task :repo, :except => { :no_release => true } do
        set :branch, "HEAD@{1}"
        deploy.default
      end

      desc "Rewrite reflog so HEAD@{1} will continue to point to at the next previous release."
      task :cleanup, :except => { :no_release => true } do
        run "cd #{current_path}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
      end

      desc "Rolls back to the previously deployed version."
      task :default do
        rollback.repo
        rollback.cleanup
      end
    end
  end
end