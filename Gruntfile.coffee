module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    coffee:
      compile:
        files:
          'index.js': 'index.coffee'

    coffeelint:
      options:
        no_empty_param_list:
          level: 'error'
      src: ['index.coffee']

    shell:
      test:
        command: 'jasmine-focused --captureExceptions --coffee spec'
        options:
          stdout: true
          stderr: true
          failOnError: true

  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-shell')
  grunt.registerTask 'clean', -> require('rimraf').sync('index.js')
  grunt.registerTask('lint', ['coffeelint'])
  grunt.registerTask('default', ['lint', 'coffee'])
  grunt.registerTask('test', ['default', 'shell:test'])
