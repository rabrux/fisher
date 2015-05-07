gulp       = require 'gulp'
coffee     = require 'gulp-coffee'
concat     = require 'gulp-concat'
connect    = require 'gulp-connect'
imagemin   = require 'gulp-imagemin'
less       = require 'gulp-less'
sourcemaps = require 'gulp-sourcemaps'
uglify     = require 'gulp-uglify'
watch      = require 'gulp-watch'

paths =
  scripts: [
    'dev/*.coffee'
    'dev/coffee/**/*.coffee'
  ]
  styles: [
    'dev/less/*.coffee'
    'dev/config/main.less'
  ]

gulp.task 'copy', ->
  gulp.src('dev/index.html').pipe gulp.dest('www')
  gulp.src(['dev/lib/**']).pipe gulp.dest('www/lib')
  gulp.src(['dev/config/main.js']).pipe gulp.dest('www/config')

gulp.task 'compile', ->
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


gulp.task 'default', [
  'copy'
  'compile'
]
