module CommomFunctions
  def number_generator(int)
    ([*'0'..'9']).shuffle.take(int).join
  end
  def char_generator(int)
    ([*'A'..'Z']).shuffle.take(int).join
  end
  def number_to_unicode(n)
    n = n.to_s
    result = '003'
    result << n[0]
    result << '003'
    result << n[1]
    result << '003'
    result << n[2]
    result << '003'
    result << n[3]
    result
  end
end