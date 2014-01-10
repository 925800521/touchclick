module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      test:
        files:
          'tmp/spec/test.js': 'test/spec/test.coffee'

    browserify:
      dist:
        files:
          'tmp/touchclick.js': 'src/touchclick.coffee'
        options:
          transform: ['coffeeify']
          ignore: ['jquery']

    uglify:
      dist:
        options:
          report: 'min'
          preserveComments: 'some'
        src: 'tmp/touchclick.js'
        dest: 'touchclick.js'

    copy:
      full:
        files: [
          src: 'tmp/touchclick.js'
          dest: 'touchclick.js'
        ]

    clean:
      test: ['tmp']

    mocha:
      test:
        src: ['test/index.html']
        options:
          bail: true
          log: true
          reporter: 'Nyan'
          run: true
          timeout: 10000

  # Load installed tasks
  grunt.file.glob
  .sync('./node_modules/grunt-*/tasks')
  .forEach(grunt.loadTasks)

  # Shortcuts
  grunt.registerTask 'test', ['clean', 'browserify', 'coffee', 'mocha']
  grunt.registerTask 'b', ['test', 'uglify', 'clean']
  grunt.registerTask 'debug', ['clean', 'browserify', 'copy']

  # Default task
  grunt.registerTask 'default', 'b'
