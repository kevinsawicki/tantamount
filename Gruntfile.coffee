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

  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.registerTask 'clean', -> require('rimraf').sync('index.js')
  grunt.registerTask('lint', ['coffeelint'])
  grunt.registerTask('default', ['lint', 'coffee'])
