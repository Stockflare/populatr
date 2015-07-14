FROM stockflare/base

ENTRYPOINT ["bundle", "exec", "ambassador", "populate"]
