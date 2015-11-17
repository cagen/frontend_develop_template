module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    # Metadata.
    meta:
      distPath:   'dist/'
      vendorPath: 'vendor/'

    watch:
      script:
        files: 'js/**'
        tasks: ['coffee', 'concat']
      style:
        files: 'css/**'
        tasks: ['sass', 'concat']
      otherFiles:
        files: ['img/**', 'html/**', 'vendor/**']
        tasks: ['concat', 'copy']
      config:
        files: ['gruntfile.coffee', 'bower.json', 'package.json']
        tasks: ['bower', 'sass', 'coffee', 'clean', 'concat', 'copy']


    concat:
      options:
        separator: ';\n' # If minified before concat
      js:
        src: [
          'vendor/jquery/jquery.js'
          'vendor/video.js/js/video.js'

          # MPEG Dash
          'vendor/dashjs/js/dash.debug.js'
          'vendor/videojs-contrib-dash/js/videojs-dash.js'

          # HLS
          'vendor/videojs-contrib-media-sources/js/videojs-media-sources.js'
          'vendor/videojs-contrib-hls/js/videojs.hls.js'

          # Feature Detection
          'vendor/radiant-medialyzer/rml.js'

          'js/compile/*.js'
        ]
        dest: 'dist/js/application.js'
      css:
        src: [
          # 'vendor/bootstrap/css/bootstrap.css'
          'vendor/video.js/css/video-js.css'
          "css/compile/*.css"
        ]
        dest: 'dist/css/application.css'

    bower:
      install:
        options:
          targetDir: 'vendor'
          layout: 'byComponent'
          # install: true
          verbose: true
          cleanTargetDir: true
          # cleanBowerDir: false
          # bowerOptions: {}

    clean:
      dist: ["dist/**"]

    coffee:
      main:
        files:
          'js/compile/main.js': ['js/videojs_dash_resolution.coffee', 'js/main.coffee'] # compile and concat into single file

    sass:
      dist:
        options:
          style: 'expanded'
          sourcemap: 'none'
        files:
          'css/compile/main.css': 'css/main.scss'
    copy:
      fonts:
        expand: true
        cwd: 'vendor/bootstrap/font/'
        src: ['**']
        dest: '<%= meta.distPath %>/fonts/'
      videoFonts:
        expand: true
        cwd: 'vendor/video.js/font/'
        src: ['**']
        dest: '<%= meta.distPath %>/fonts/'
      videojsSwf:
        expand: true
        cwd: 'vendor/video.js/swf/'
        src: ['**']
        dest: '<%= meta.distPath %>/swf/'
      imgs:
        expand: true
        cwd: 'img/'
        src: ['**']
        dest: 'dist/img'
      htmls:
        expand: true
        flatten: true
        cwd: 'html/'
        src: ['**']
        dest: '<%= meta.distPath %>'
        filter: 'isFile'

    connect:
      server:
        options:
          port: 9001,
          base: 'dist'

  grunt.loadNpmTasks('grunt-bower-task')
  grunt.loadNpmTasks('grunt-contrib-sass')
  grunt.loadNpmTasks('grunt-contrib-coffee')

  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-copy')

  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-contrib-watch')

  # grunt.loadNpmTasks('grunt-contrib-jshint')

  grunt.registerTask('default', ['bower', 'sass', 'coffee', 'clean', 'concat', 'copy', 'connect', 'watch'])
