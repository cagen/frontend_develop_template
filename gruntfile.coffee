module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    # Metadata.
    meta:
      distPath:   'dist/'
      vendorPath: 'vendor/'

    watch:
      files: ['js/**', 'css/**', 'img/**', 'html/**', 'vendor/**']
      tasks: ['coffee', 'sass', 'concat', 'copy']

    concat:
      options:
        separator: ';\n' # If minified before concat
      js:
        src: [
          'vendor/jquery/jquery.js'
          'vendor/bootstrap/js/bootstrap.js'
          'js/compile/*.js'
        ]
        dest: 'dist/js/application.js'
      css:
        src: [
          'vendor/bootstrap/css/bootstrap.css'
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
      compile:
        files:
          'js/compile/main.js': ['js/main.coffee'] # compile and concat into single file

    sass:
      dist:
        options:
          style: 'expanded'
        files:
          'css/compile/main.css': 'css/main.scss'

    copy:
      fonts:
        expand: true
        cwd: 'vendor/bootstrap/font/'
        src: ['**']
        dest: '<%= meta.distPath %>/fonts/'
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

  grunt.registerTask('default', ['bower', 'sass', 'coffee', 'clean', 'concat', 'copy', 'connect', 'watch'])
