require 'fileutils'

namespace "ckeditor" do
  desc "Create nondigest versions of all ckeditor digest assets"
  task "nondigest" => [:environment] do
    source = Rails.root.join('app', 'assets', 'javascripts', 'ckeditor', 'plugins')
    dest = Rails.root.join('public', 'assets', 'ckeditor', 'plugins')
    FileUtils.copy_entry source, dest
  end
end

# Based on rake task from asset_sync gem
if Rake::Task.task_defined?("assets:precompile")
  Rake::Task["assets:precompile"].enhance do
    Rake::Task["ckeditor:nondigest"].invoke if defined?(Ckeditor) && Ckeditor.run_on_precompile?
  end
end