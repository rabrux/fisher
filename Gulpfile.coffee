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
  scripts: [
    'dev/coffee/*.coffee'
    'dev/coffee/**/*.coffee'
  ]
  styles: [
    'dev/less/*.less'
    'dev/config/main.less'
  ]
  templates: [
    # 'dev/templates/*.html'
    'dev/templates/**/*.html'
  ]

appPaths = [
  'www/*.html'
  'www/*.js'
  'www/*.css'
]

gulp.task 'copy', ->
  gulp.src(['dev/lib/**']).pipe gulp.dest('www/lib')
  gulp.src(['dev/config/main.js']).pipe gulp.dest('www/config')
  return

gulp.task 'compile-js', ->
  # Minify and copy all JavaScript (except vendor scripts)
  # with sourcemaps all the way down
  gulp.src(paths.scripts)
    .pipe(sourcemaps.init())
      .pipe(coffee())
      .pipe(uglify())
      .pipe(concat('app.min.js'))
    .pipe(sourcemaps.write())
    .pipe gulp.dest('www/app')
  return

gulp.task 'less', ->
  gulp.src('dev/config/main.less')
    .pipe(less())
    .pipe(minifyCSS())
    .pipe(concat('style.min.css'))
    .pipe gulp.dest('www/css')

gulp.task 'html', ->
  gulp.src(paths.templates).pipe(minifyHTML()).pipe gulp.dest('www/templates')

gulp.task 'index', ->
  gulp.src('dev/index.html').pipe gulp.dest('www')

###*
# Server
###
gulp.task 'connect', ->
  connect.server
    root: 'www'
    livereload: true
  return

###*
# Livereload
###
gulp.task 'livereload', ->
  connect.reload()
  return

###*
# Watch custom files
###
gulp.task 'watch', ->
  # gulp.watch [ paths.images ], [ 'custom-images' ]
  gulp.watch [ paths.styles ], [ 'less' ]
  gulp.watch [ paths.scripts ], [ 'compile-js' ]
  gulp.watch [ paths.templates ], [ 'html' ]
  gulp.watch [ 'dev/index.html' ], [ 'index' ]
  gulp.watch [ appPaths ], [ 'livereload' ]
  return

gulp.task 'default', [
  'index'
  'copy'
  'html'
  'compile-js'
  'less'
  'connect'
  'watch'
]
