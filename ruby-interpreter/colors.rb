class Color
  def self.colorize(text, color_code)
    "\033[#{color_code}m#{text}\033[0m"
  end

  def self.green text
    colorize(text, 32)
  end

  def self.blue text
    colorize(text, 34)
  end

  def self.red text
    colorize(text, 31)
  end

  def self.yellow text
    colorize(text, 33)
  end
end
