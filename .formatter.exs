[
  import_deps: [:open_api_spex, :ecto, :ecto_sql, :phoenix],
  subdirectories: ["priv/*/migrations"],
  plugins: [Phoenix.LiveView.HTMLFormatter],
  inputs: ["*.{heex,ex,exs}", "{config,lib,test}/**/*.{heex,ex,exs}", "priv/*/seeds.exs"],
  export: [
    locals_without_parens: [
      assert_enqueued: 1,
      assert_enqueued: 2,
      refute_enqueued: 1,
      refute_enqueued: 2
    ]
  ],
  locals_without_parens: [
    assert_enqueued: 1,
    assert_enqueued: 2,
    refute_enqueued: 1,
    refute_enqueued: 2
  ]
]
