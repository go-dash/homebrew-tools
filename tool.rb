class Tool < Formula
  desc "Command line tool for code generation of GoDash library implementations"
  homepage "https://github.com/go-dash/_gen"

  # Source code archive. Each tagged release will have one
  url "https://github.com/go-dash/_gen/archive/0.0.1.tar.gz"
  sha256 "19d876bf4e7628460035f04beeea4ab3e0a1061d6edf53b11dd854de76cf5b6e"
  head "https://github.com/go-dash/_gen"
  
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    bin_path = buildpath/"src/github.com/go-dash/_gen"
    bin_path.install Dir["*"]
    
    cd bin_path do
      # Install the compiled binary into Homebrew's `bin` - a pre-existing
      # global variable
      system "go", "build", "-o", bin/"_gen", "./"
    end
  end

  # Homebrew requires tests.
  test do
    # "2>&1" redirects standard error to stdout. The "2" at the end means "the
    # exit code should be 2".
    assert_match "_gen 0.0.1 (go-dash code generator)", shell_output("#{bin}/_gen --version 2>&1", 0)
  end
end
