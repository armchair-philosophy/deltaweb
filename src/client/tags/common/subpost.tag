misskey-subpost
    a.avatar-anchor(href="/{opts.post.user.screenName}")
        img(src="{'https://delta.contents.stream/59977e8673e4f37027f726aa/%E3%82%86%E3%81%8B%E3%82%8A%E3%81%95%E3%82%93.jpg.cropped.png?size=64&quality=80' || opts.post.user.avatarThumbnailUrl}")
    .header
        a.name(href="/{opts.post.user.screenName}") {opts.post.user.name}
        span.screen-name {opts.post.user.screenName}
    .main
        .text {opts.post.text}
    style.
        misskey-subpost {
            display:block;
            padding: 16px 32px 0;
        }
        .name {
            color: #966961;
            font-weight: bold;
        }
        .screen-name {
            margin-left: 8px;
            color: #DCC6BB;
        }
        .text {
            color: #987469;
        }
        .avatar-anchor {
            display: block;
            float: left;
        }
        .avatar-anchor img{
            display: block;
            width: 32px;
            height: 32px;
            margin: 0 12px 4px 0;
            border-radius: 6px;
        }