module CommomFunctions
  def number_generator(int)
    ([*'0'..'9']).shuffle.take(int).join
  end
  def char_generator(int)
    ([*'A'..'Z']).shuffle.take(int).join
  end
end