class Redirector
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    if request.host != HOST && request.path !~ %r{^/api}
      fake_request = Rack::Request.new(env.merge("HTTP_HOST" => HOST))
      redirect_to(fake_request.url)
    elsif request.path =~ %r{^/(book|chapter|export|read|shelf|syndicate)}
      redirect_to("http://docs.rubygems.org#{request.path}")
    elsif request.path =~ %r{^/pages/docs$}
      redirect_to("http://guides.rubygems.org")
    elsif request.path =~ %r{^/pages/gem_docs$}
      redirect_to("http://guides.rubygems.org/command-reference")
    elsif request.path =~ %r{^/pages/api_docs$}
      redirect_to("http://guides.rubygems.org/rubygems-org-api")
    else
      @app.call(env)
    end
  end

  private

  def redirect_to(url)
      [301, {"Location" => url}, []]
  end
end
