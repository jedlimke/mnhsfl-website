FROM ruby:3.3-alpine
LABEL maintainer="MNHSFL"
WORKDIR /site
RUN apk add --no-cache build-base
# Copy only Gemfile first (Gemfile.lock may not exist yet)
COPY Gemfile ./
RUN gem install bundler && bundle install
# Copy the rest of the files
COPY . .
EXPOSE 4000
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--port", "4000"]
