gulp       = require 'gulp'
coffee     = require 'gulp-coffee'
concat     = require 'gulp-concat'
connect    = require 'gulp-connect'
imagemin   = require 'gulp-imagemin'
less       = require 'gulp-less'
minifyCSS  = require 'gulp-minify-css'
minifyHTML = require 'gulp-minify-html'
sourcemaps = require 'gulp-sourcemaps'
uglify     = require 'gulp-uglify'
watch      = require 'gulp-watch'

paths =
  config: 'dev/config/main.js'
  scripts: [
    'dev/coffee/*.coffee'
    'dev/coffee/**/*.coffee'
  ]
  styles: [
    'dev/less/*.less'
    'dev/config/main.less'
  ]
  templates: [
    'dev/templates/*.html'
    'dev/templates/**/*.html'
  ]
  images: [
    'dev/images/**/*.*'
    'dev/images/*.*'
  ]
  app: [
    'www/**/*.js'
    'www/**/*.css'
    'www/templates/**/*.html'
    'www/templates/*.html'
    'www/images/*.*'
    'www/images/**/*.*'
    'www/*.html'
  ]

gulp.task 'copy-images', ->
  gulp.src(paths.images)
    .pipe gulp.dest('www/images')
  return

gulp.task 'build-config', ->
  gulp.src(['dev/config/main.js']).pipe gulp.dest('www/config')
  return

gulp.task 'copy-lib', ->
  gulp.src(['dev/lib/**']).pipe gulp.dest('www/lib')
  return

gulp.task 'compile-coffee', ->
  gulp.src(paths.scripts)
    .pipe(coffee().on('error', (err) ->
      console.log err.message
      @emit 'end'
    ))
    .pipe(uglify())
    .pipe(concat('app.min.js'))
    .pipe gulp.dest('www/app')
  return

gulp.task 'less', ->
  return gulp.src('dev/config/main.less')
    .pipe(less().on('error', (err) ->
      console.log err.message
      @emit 'end'
    ))
    .pipe(minifyCSS())
    .pipe(concat('style.min.css'))
    .pipe(gulp.dest('www/css'))

gulp.task 'templates', ->
  gulp.src(paths.templates).pipe(minifyHTML()).pipe gulp.dest('www/templates')
  return

gulp.task 'index', ->
  gulp.src('dev/index.html').pipe gulp.dest('www')
  return

gulp.task 'connect', ->
  connect.server
    root: 'www'
    port: 8181
    livereload: true
  return

gulp.task 'refresh', ->
  gulp.src(paths.app)
    .pipe connect.reload()
  return

###*
# Watch files
###
gulp.task 'watch', ->
  gulp.watch [ paths.config ], [ 'build-config' ]
  gulp.watch [ paths.scripts ], [ 'compile-coffee' ]
  gulp.watch [ paths.styles ], [ 'less' ]
  gulp.watch [ paths.templates ], [ 'templates' ]
  gulp.watch [ 'dev/index.html' ], [ 'index' ]
  gulp.watch [ paths.images ], [ 'copy-images' ]
  # gulp.watch [ paths.app ], [ 'refresh' ]
  return

gulp.task 'default', [
  'build-config'
  'copy-lib'
  'copy-images'
  'compile-coffee'
  'less'
  'templates'
  'index'
  'connect'
  'watch'
]
