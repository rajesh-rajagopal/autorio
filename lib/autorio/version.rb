module Autorio
  class Version < String
    VERSION_REGEX = %r{
    \A(?<major>\d+)
    \.(?<minor>\d+)
    (\.(?<patch>\d+))?
    (-(?<rc>rc(?<rc_number>\d*)))?\z
  }x

    def initialize(version_string)
      super(version_string)

      raise "Bad #{version_string}. Good examples [2.0.0-rc1, 2.0.0]" unless valid?

      if valid? && extract_from_version(:patch, fallback: nil).nil?
        rc? ? super(to_rc(rc)) : super(to_patch)
      end
    end

    def patch?
      patch.positive?
    end

    def major
      @major ||= extract_from_version(:major).to_i
    end

    def minor
      @minor ||= extract_from_version(:minor).to_i
    end

    def patch
      @patch ||= extract_from_version(:patch).to_i
    end

    def to_rc(number = 1)
      "#{to_patch}-rc#{number}"
    end

    def to_patch
      "#{major}.#{minor}.#{patch}"
    end

    def to_patch_with(patch)
      "#{major}.#{minor}.#{patch}"
    end

    def rc
      return unless rc?

      @rc ||= extract_from_version(:rc_number).to_i
    end

    def rc?
      return @is_rc if defined?(@is_rc)

      @is_rc = extract_from_version(:rc, fallback: false)
    end

    def release?
      valid? && !rc? && !ee?
    end

    def next_minor
      "#{major}.#{minor + 1}.0"
    end

    def previous_patch(decr = 1)
      return unless patch?

      new_patch = self.class.new("#{major}.#{minor}.#{patch - decr}")

      new_patch
    end

    def next_patch
      new_patch = self.class.new("#{major}.#{minor}.#{patch + 1}")

      new_patch
    end

    def from_last_one_patch
      return (patch..patch) if (patch - 1 < 0)

      ((patch - 1)..patch)
    end

    def from_last_one_rc
      return (rc..rc) if (rc - 1 < 0)

      ((rc - 1)..rc)
    end

    def last_two
      if rc?
        from_last_one_rc.to_a.map { |r| to_rc(r) }
      else
        from_last_one_patch.to_a.map { |p| to_patch_with(p) }
      end
    end

    def valid?
      self =~ self.class::VERSION_REGEX
    end

    private

    def tag_for(version, ee: false)
      version = version.to_ee if ee

      "#{version}"
    end

    def extract_from_version(part, fallback: 0)
      match_data = self.class::VERSION_REGEX.match(self)
      if match_data && match_data.names.include?(part.to_s) && match_data[part]
        String.new(match_data[part])
      else
        fallback
      end
    end
  end
end
