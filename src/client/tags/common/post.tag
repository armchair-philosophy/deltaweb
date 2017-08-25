misskey-post(id="{post().id}")
    .repost-info(if="{opts.post.type == 'repost'}")
        img(src="{opts.post.user.avatarThumbnailUrl}")
        i.fa.fa-retweet
        | Reposted by 
        a.name(href="/{opts.post.user.screenName}") {opts.post.user.name}
    misskey-subpost(if="{opts.post.type == 'reply'}",post="{opts.post.inReplyToPost}")
    .main
        .avatar-area
            a(href="/{post().user.screenName}")
                img(src="{post().user.avatarThumbnailUrl}")
        .header
            .author
                a.name(href="/{post().user.screenName}") {post().user.name}
                span.screen-name {post().user.screenName}
        .text: misskey-text-render(text="{post().text}")
        .files
            ol: li(each="{file in files}")
                a(href="{file.url}")
                    img(src="{file.thumbnailUrl}")

    .footer
        ul
            li: button(type="button", onclick="{reply}"): i.fa.fa-reply
            li: button(type="button", onclick="{repost}", class="{active: this.post().isReposted}"): i.fa.fa-retweet
            li: button(type="button", onclick="{like}", class="{active: this.post().isLiked}"): i.fa.fa-thumbs-o-up
    script.
        import "./subpost.tag"
        import "./text-render.tag"
        this.post = function() {
            return this.opts.post.post || this.opts.post
        }
        this.reply = function() {
            var text = prompt("リプライ", "@"+this.post().user.screenName+" ")
            if (text == null) return
            apiCall("posts/reply", {
                "text": text,
                "in-reply-to-post-id": this.post().id
            }).then(function(){
                // いい話
            })
        }
        this.repost = function() {
            apiCall("posts/repost", {
                "post-id": this.post().id
            }).then(function(){
                location.reload()
            })
        }
        this.like = function() {
            apiCall("posts/like", {
                "post-id": this.post().id
            }).then(function(){
                location.reload()
            })
        }
    style.
        misskey-post {
            display:block;
            background: #fffbfb;
            padding: 12px 0;
            margin: 0;
            margin-bottom: 1px;
        }
        > .main {
            padding: 16px 32px;
        }
        .header {
            border-bottom: 4px;
        }
        .avatar-area {
            float:left;
            margin-right:16px;
        }
        .avatar-area img{
            width:58px;
            height:58px;
            border-radius: 8px;
            vertical-align: bottom;
        }
        .author a{
            color: #736060;
            text-decoration: none;
        }
        .author .screen-name {
            margin-left: 8px;
            color: #e2d1c1; 
        }
        > .main > .text {
            color: #8c615a;
        }
        .footer {
            position:relative;
            display: block;
            z-index: 1;
            margin-top: -12px;
        }
        .footer:after {
            content: "";
            display: block;
            clear: both;
        }
        .footer ul{
            display: block;
            float:right;
            list-style:none;
            margin:0;
            padding:0;
        }
        .footer li{
            display: inline-block;
            margin: 0;
            padding: 0 16px;
            min-width: 2.5em;
        }
        .footer button {
            background: transparent;
            padding: 8px;
            margin: 0;
            color: #d8c5ad;
            font-size:1em;
            opacity: 0.5;
        }
        misskey-post:hover .footer button{
            opacity: 1;
        }
        .footer button.active {
            color: #11491d;
            opacity:1;
        }
        .repost-info{
            margin: 0;
            padding: 8px 32px;
            line-height: 28px;
            color: #57bb00;
        }
        .repost-info img{
            float:left;
            height:28px;
            width:28px;
            margin-right: 8px;
        }
        .repost-info i{
            margin-right: 4px;
        }
        a.name{
            font-weight: bold;
        }
        .reply-post {
            padding: 16px 32px 0;
        }
        .files a *{
            max-width: 100%;
            max-height: 256px;
        }
