Gem::Specification.new do |s|
  s.name        = "capistrano_fast_git_deploy"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Harri Kauhanen"]
  s.email       = ["harri.kauhanen@gmail.com"]
  s.homepage    = "http://github.com/harrikauhanen/capistrano_fast_git_deploy"
  s.summary     = "Extremelly fast deployments using git commands"
  s.description = "Fast deployments are achieved using git commands for new deployment and possible rollbacks. The default Capistrano folder structure with multiple folders under 'releases' folder is not used at all."
 
  s.required_rubygems_version = ">= 1.3.6"
  s.files        = Dir.glob("{lib}/**/*") + ['MIT_LICENSE', 'README.md', 'ROADMAP.md', 'CHANGELOG.md']
  s.require_paths = ['lib']
  
  s.add_dependency(%q<capistrano>, [">= 2.5.10"])
end