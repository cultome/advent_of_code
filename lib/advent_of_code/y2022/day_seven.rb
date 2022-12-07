class ElfFile
  attr_accessor :name, :size, :parent

  def initialize(name, size, parent)
    @parent = parent
    @name = name
    @size = size
  end
end

class ElfFolder
  attr_accessor :name, :files, :folders, :parent

  def initialize(name, parent)
    @parent = parent
    @name = name
    @files = []
    @folders = []
  end

  def cd(dirname)
    if dirname == '/'
      new_dir = self

      new_dir = new_dir.parent while !new_dir.parent.nil?

      new_dir
    elsif dirname == '..'
      parent
    else
      folders.find { |f| f.name == dirname }
    end
  end

  def size
    files.map(&:size).sum + folders.map(&:size).sum
  end

  def find_dirs(max_size, acc = [])
    acc << self if size <= max_size

    folders.each do |folder|
      folder.find_dirs(max_size, acc)
    end

    acc
  end

  def walk_tree(acc = [])
    acc << self unless acc.include? self

    folders.each do |folder|
      folder.walk_tree acc
    end

    acc
  end
end

def parse_filesystem
  root = ElfFolder.new '/', nil
  current_folder = root

  input.each do |ln|
    if ln.start_with? '$ '
      # command
      if ln.start_with? '$ cd'
        dirname = ln[5..]

        current_folder = current_folder.cd dirname
      elsif ln.start_with? '$ ls'
        # no nothing
      end
    elsif ln.start_with? 'dir '
      # directory
      _, name = ln.split(' ')

      current_folder.folders << ElfFolder.new(name, current_folder)
    elsif ln =~ /^\d/
      # file
      size, name = ln.split(' ')

      current_folder.files << ElfFile.new(name, size.to_i, current_folder)
    end
  end

  root
end

def first
  root = parse_filesystem
  root.find_dirs(100_000).map(&:size).sum
end

def second
  root = parse_filesystem

  total = 70_000_000
  required = 30_000_000
  used = root.size
  to_free = required - (total - used)

  root.walk_tree.map(&:size).sort.find { |value| value >= to_free }
end

def input
  open('inputs/y2022/day_seven.txt').map(&:chomp)
end
