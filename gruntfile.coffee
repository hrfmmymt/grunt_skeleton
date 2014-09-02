module.exports = (grunt) =>

  # BUILD_ORDERED_LIST = [
  #   './vendor/jquery/jquery.js'
  #   './vendor/underscore/underscore.js'
  #   './vendor/backbone/backbone.js'
  # ];

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    jade:
      compile:
        options:
          pretty: true
        files: [
          expand: true
          cwd: 'src/jade'
          src: '*.jade'
          dest: 'public/'
          ext: '.html'
        ]
    sass:
      compile:
        files: [
          expand: true
          cwd: 'src/scss'
          src: '*.scss'
          dest: 'public/css/'
          ext: '.css'
        ]

    coffee:
      compile:
        options:
          bare: true
        files: [
          expand: true
          cwd: 'src/coffee'
          src: '*.coffee'
          dest: 'public/js/'
          ext: '.js'
        ]

    bower:
      install:
        options:
          targetDir: './vendor'
          layout: 'byType'
          install: true
          cleanTargetDir: true
          cleanBowerDir: false

    # uglify:
    #   compress_target:
    #     files: [
    #         expand: true
    #         cwd: './vendor'
    #         src: ['**/*.js']
    #         dest: './vendor'
    #         ext: '.js'
    #     ]

    concat:
      dist:
        src: './vendor/**/*.js'
        # src: BUILD_ORDERED_LIST
        dest: './public/js/vendor.js'

    connect:
      server:
        options:
          port: 9001
          hostname: '*'
          base: 'public'
          livereload: 35729

    esteWatch:
      options:
        dirs: [
          'src/coffee/**'
          'src/jade/**'
          'src/scss/**'
          'public/**'
        ]
        livereload:
          enabled: true
          extensions: ['js', 'html', 'css']
          port: 35729
      'coffee': (path) ->
        ['newer:coffee']
      'jade': (path) ->
        ['newer:jade']
      'scss': (path) ->
        ['newer:sass']

  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-este-watch'
  grunt.loadNpmTasks 'grunt-newer'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.registerTask 'make', ['bower', 'newer:coffee', 'newer:jade', 'newer:sass', 'concat']
  grunt.registerTask 'default', ['make', 'connect', 'esteWatch']