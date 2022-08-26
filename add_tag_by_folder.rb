#!/usr/bin/env ruby

def get_tag(filename)
  tag_string = `tag --list -N #{filename}`
  return tag_string.gsub(/[\n]+/,'').split(',')
end

def add_tags(filename, tags)
  tag_string = tags.join(',')
  puts "x"
  x = "tag --add #{tag_string} #{filename}"
  puts "x: #{x}"
  `#{x}`
  puts "y"
end

def add_tag(filename, tag)
  add_tags(filename, [tag])
end

def remove_all_tag(filename)
  tag_string = `tag --remove \\* #{filename}`
end

def get_folders(file)
  dir = file.split('/')
  return dir[0..-2].map { |d| d.gsub(/[\n]+/,'').gsub(' ', '\ ') }
  # file = dir[-1]
  # return directory
end

def travel
  # glob_dir = "../add_tag_by_folder/example/"
  glob_dir = ARGV[0]
  glob_dirs = glob_dir.split('/')
  Dir.glob("#{glob_dir}**/*.{jpg,jpeg,png}").each { |file|
    # puts "File: #{file} Tag: #{get_tag(file).join(',')}"
    string_file = file.gsub(' ', '\ ').gsub('/','\/').gsub('&','\&').gsub('|', '\|')
    directories = get_folders(file)
    tags = directories - glob_dirs
    # remove_all_tag(string_file)
    add_tags(string_file, tags)

    puts "File: #{string_file}"
    puts "Tags: #{get_tag(string_file)}"
    puts " "
  }
end

travel



