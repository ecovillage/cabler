# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

# Guard file for livereload and minitest
# More general info at https://github.com/guard/guard#readme

# run minitest but exclude tests with "System" in their name (kind of a workaround, we do not want system tests to run at every file change)
group 'test' do
  guard :minitest, spring: 'bin/rails test', test_folders: ['test/models', 'test/controllers'] , cli: '--exclude "/.*system.*/"' do
    # with Minitest::Unit
    watch(%r{^test/(.*)\/?test_(.*)\.rb$})
    watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
    watch(%r{^app/(.+)\.rb$}) { 'test' }
    watch(%r{^test/test_helper\.rb$})      { 'test' }
  
    # with Minitest::Spec
    # watch(%r{^spec/(.*)_spec\.rb$})
    # watch(%r{^lib/(.+)\.rb$})         { |m| "spec/#{m[1]}_spec.rb" }
    # watch(%r{^spec/spec_helper\.rb$}) { 'spec' }
  
    # Rails 4
    # watch(%r{^app/(.+)\.rb$})                               { |m| "test/#{m[1]}_test.rb" }
    # watch(%r{^app/controllers/application_controller\.rb$}) { 'test/controllers' }
    # watch(%r{^app/controllers/(.+)_controller\.rb$})        { |m| "test/integration/#{m[1]}_test.rb" }
    # watch(%r{^app/views/(.+)_mailer/.+})                    { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
    # watch(%r{^lib/(.+)\.rb$})                               { |m| "test/lib/#{m[1]}_test.rb" }
    # watch(%r{^test/.+_test\.rb$})
    # watch(%r{^test/test_helper\.rb$}) { 'test' }
  end
end

group 'livereload' do
  guard 'livereload' do
    extensions = {
      css: :css,
      scss: :css,
      sass: :css,
      js: :js,
      coffee: :js,
      html: :html,
      png: :png,
      gif: :gif,
      jpg: :jpg,
      jpeg: :jpeg,
      # less: :less, # uncomment if you want LESS stylesheets done in browser
    }
  
    rails_view_exts = %w(erb haml slim)
  
    # file types LiveReload may optimize refresh for
    compiled_exts = extensions.values.uniq
    watch(%r{public/.+\.(#{compiled_exts * '|'})})
  
    extensions.each do |ext, type|
      watch(%r{
            (?:app|vendor)
            (?:/assets/\w+/(?<path>[^.]+) # path+base without extension
             (?<ext>\.#{ext})) # matching extension (must be first encountered)
            (?:\.\w+|$) # other extensions
            }x) do |m|
        path = m[1]
        "/assets/#{path}.#{type}"
      end
    end
  
    # file needing a full reload of the page anyway
    watch(%r{app/views/.+\.(#{rails_view_exts * '|'})$})
    watch(%r{app/helpers/.+\.rb})
    watch(%r{config/locales/.+\.yml})
  end
end
