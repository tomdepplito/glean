class Preference
  PREFERENCE_KEY = "preferences"

  def self.get
    preference = $redis.get(PREFERENCE_KEY)
    preference.blank? ? [] : JSON(preference)
  end

  def self.add(*args)
    preferences = get + args
    $redis.set(PREFERENCE_KEY, preferences)
  end

  def self.remove(*args)
    preferences = get - args
    $redis.set(PREFERENCE_KEY, preferences)
  end
end
