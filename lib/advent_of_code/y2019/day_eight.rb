def first
  width = 25
  height = 6

  layers = read_image(input, width, height)

  groups = layers.map { |layer| layer.group_by { |pixel| pixel } }
  img_layer = groups.min { |h1, h2| h1[0].size <=> h2[0].size }

  img_layer[1].size * img_layer[2].size
end

def second
  width = 25
  height = 6
  transparent = 2

  result = []

  layers = read_image(input, width, height)

  (width * height).times do |idx|
    layers.each do |layer|
      if layer[idx] != transparent
        result[idx] = layer[idx]
        break
      end
    end
  end

  height.times do |h|
    result.slice(h * width, width).join.gsub("0", " ").gsub("1", "#")
  end

  result.join
end

def read_image(data, width, height)
  layers = []
  idx = 0

  begin
    layer = data.slice(idx, width * height)
    layers << layer
    idx += width * height
  end while idx < data.size

  layers
end

def input
  File.read('inputs/y2019/day_eight.txt').chomp.split("").map(&:to_i)
end
