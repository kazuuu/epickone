module CommomFunctions
  def number_generator(int)
    ([*'0'..'9']).shuffle.take(int).join
  end
  def char_generator(int)
    ([*'a'..'z']).shuffle.take(int).join
  end
  def formata_telefone(n_telefone)
    if n_telefone.length == 11
      tel_formatado = "("
      tel_formatado << n_telefone[0..1]
      tel_formatado << ") "
      tel_formatado << n_telefone[2..4]
      tel_formatado << "-"
      tel_formatado << n_telefone[5..7]
      tel_formatado << "-"
      tel_formatado << n_telefone[8..10]
      tel_formatado
    elsif n_telefone.length == 10
      tel_formatado = "("
      tel_formatado << n_telefone[0..1]
      tel_formatado << ") "
      tel_formatado << n_telefone[2..5]
      tel_formatado << "-"
      tel_formatado << n_telefone[6..9]
      tel_formatado
    else
      tel_formatado = "("
      tel_formatado << n_telefone[0..1]
      tel_formatado << ") "
      tel_formatado << n_telefone[2..n_telefone.length-1]
      tel_formatado
    end
  end
end