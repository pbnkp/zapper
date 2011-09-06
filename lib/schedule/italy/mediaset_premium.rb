module Schedule::Italy
  class MediasetPremium < Base
    unloadable

    def xml_source
      "http://www.guidatv.mediasetpremium.it/export/palinsesto_day_0.xml"
    end

    def map(data)
      data["palinsesto"]["giorno"][0]["canale"].map do |ch|
        {
          id: "#{id}/#{ch["description"].gsub(" ", "_").underscore}",
          name: ch["description"],
          programs: ch["prg"].map do |prg|
            {
              start: prg["orainizio"],
              end: prg["orainizio"],
              type: map_kind(prg["tipologia"]),
              duration: prg["durata"],
              title: prg["titolo"],
              description: nil,
              link: prg["linkScheda"],
              year: decode_dashes(prg["anno"]),
              country: decode_dashes(prg["paese"])
            }
          end
        }
      end
    end

    def decode_dashes(string)
      return nil if string.blank?
      (string == "--") ? nil : string
    end

    def map_kind(kind)
      kind.gsub(" ", "_").underscore
    end

  end
end
