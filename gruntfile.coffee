module.exports = (grunt) ->

  require('load-grunt-tasks')(grunt)

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    # Metadata.
    meta:
      distPath:   'dist'
      vendorPath: 'vendor'

    watch:
      script:
        files: 'js/**'
        tasks: ['coffee', 'concat']
      style:
        files: 'css/**'
        tasks: ['sass', 'concat']
      otherFiles:
        files: ['img/**', 'html/**', '<%= vendorPath %>/**']
        tasks: ['concat', 'copy']
      config:
        files: ['gruntfile.coffee', 'bower.json', 'package.json']
        tasks: ['bower', 'sass', 'coffee', 'clean', 'concat', 'copy']


    concat:
      options:
        separator: ';\n' # If minified before concat
      js:
        src: [
          '<%= vendorPath %>/jquery/jquery.js'
          'js/compile/*.js'
        ]
        dest: '<%= meta.distPath %>/js/application.js'
      css:
        src: [
          '<%= vendorPath %>/bootstrap/css/bootstrap.css'
          "css/compile/*.css"
        ]
        dest: '<%= meta.distPath %>/css/application.css'

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
      dist: ["<%= meta.distPath %>/**"]

    coffee:
      main:
        files:
          'js/compile/main.js': [
            'js/main.coffee'
          ] # compile and concat into single file

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
        cwd: '<%= vendorPath %>/bootstrap/font/'
        src: ['**']
        dest: '<%= meta.distPath %>/fonts/'
      imgs:
        expand: true
        cwd: 'img/'
        src: ['**']
        dest: '<%= meta.distPath %>/img'
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
          base: '<%= meta.distPath %>'

  # grunt.loadNpmTasks('grunt-bower-task')
  # grunt.loadNpmTasks('grunt-contrib-sass')
  # grunt.loadNpmTasks('grunt-contrib-coffee')
  #
  # grunt.loadNpmTasks('grunt-contrib-clean')
  # grunt.loadNpmTasks('grunt-contrib-concat')
  # grunt.loadNpmTasks('grunt-contrib-copy')
  #
  # grunt.loadNpmTasks('grunt-contrib-connect')
  # grunt.loadNpmTasks('grunt-contrib-watch')

  # grunt.loadNpmTasks('grunt-contrib-jshint')

  grunt.registerTask('default', ['bower', 'clean', 'coffee', 'sass', 'concat', 'copy', 'connect', 'watch'])
