workers Integer(ENV['WEB_CONCURRENCY'] || 3)
threads_count = Integer(ENV['MAX_THREADS'] || 20)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'production' #'development'