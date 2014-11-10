x1 = 0;
x2 = 1;
x3 = 1;
x4 = 5;
while x1 < x4
  x7 = x2 + x3;
  x2 = x3;
  x3 = x7;
  x1 = x1 + 1;
end
puts "x2 = " + x2.to_s
