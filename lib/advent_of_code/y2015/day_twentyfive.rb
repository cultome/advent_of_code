def first
  # row 3010, column 3019.
  num = row_col 3010, 3019
  calculate num
end

def calculate(n)
  current = 20151125

  (n-1).times do
    current = current * 252533 % 33554393
  end

  current
end

def row_col(row, col)
  initial_value = first_value_of_row row
  find_value_of_col col, row, initial_value
end

def find_value_of_col(req_col, rowid, row_first_value)
  col_value = row_first_value

  (req_col-1).times do |colid|
    col_value += colid + rowid + 1
  end

  col_value
end

def first_value_of_row(req_row)
  col_value = 1

  req_row.times do |rowid|
    col_value += rowid
  end

  col_value
end

def second
  ""
end
