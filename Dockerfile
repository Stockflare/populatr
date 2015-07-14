FROM stockflare/base

CMD ["bundle", "exec", "ambassador", "populate"]
