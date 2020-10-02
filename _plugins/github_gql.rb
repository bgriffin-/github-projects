require_relative 'process'

module GithubGQL
  class Generator < Jekyll::Generator

    def generate(site)
      token = ENV['GITHUB_TOKEN']
      debug = ENV['DEBUG']

      unless token
        raise 'GitHub API token must be set'
      end

      if ENV['DISABLE_GQL']
        repos = {}
        topics = {}
      else
        filename = 'repos_with_topics.gql'
        gh_api = GitHubAPI.new token, filename, debug
        repos, topics = gh_api.get_gh_data
      end

      site.data['all_repos'] = repos
      site.data['all_topics'] = topics
    end
  end
end
