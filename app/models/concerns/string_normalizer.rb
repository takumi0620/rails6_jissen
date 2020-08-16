require "nkf"

module StringNormalizer
  extend ActiveSupport::Concern

  def normalize_as_email(text)
    NKF.nkf("-W -w -Z1", text).strip if text
  end

  def normalize_as_name(text)
    # NKFはrubyに標準で含まれている日本語特有の変換機能を提供する。ひらがな -> カタカナなど。
    NKF.nkf("-W -w -Z1", text).strip if text
  end

  def normalize_as_furigana(text)
    NKF.nkf("-W -w -Z1 --katakana", text).strip if text
  end

  def normalize_as_postal_code(text)
    NKF.nkf("-W -w -Z1", text).strip.gsub(/-/, "") if text
  end
end