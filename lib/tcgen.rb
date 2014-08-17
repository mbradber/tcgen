#!/usr/bin/env ruby

require 'FileUtils'

cmakeFile = 'CMakeLists.txt'
cmakeInit = 'cmake_minimum_required (VERSION 2.6)'

dirname = File.basename(Dir.getwd)

# regenerate the make file with all .cpp files in current dir
if File.exist? cmakeFile
	FileUtils.rm(cmakeFile)
end

cmakeFile = File.new(cmakeFile, "w")
cmakeFile.puts(cmakeInit)
cmakeFile.puts('project(' + dirname + ')')

srcList = Dir["*.cpp"]
srcList.each { |x| 
	cmakeFile.puts('add_executable(' + File.basename(x, ".*") + ' ' + x + ')')
}

cmakeFile.close

# generate the xcode file from the cmake lists file
`cmake -GXcode .`