# -*- coding: utf-8 -*-
Plugin.create :supprise_video_from_world do
    command(:supprise_video_from_world,
        name: '世界のサプライズ動画を作る',
        condition: lambda{ |opt| true },
        visible: true,
        role: :postbox
    ) do |opt|
        Plugin.call(:create_supprise_video_from_world, opt, false)
    end
    command(:supprise_video_from_world_sendnow,
        name: '世界のサプライズ動画を作ってすぐ送る',
        condition: lambda{ |opt| true },
        visible: true,
        role: :postbox
    ) do |opt|
        Plugin.call(:create_supprise_video_from_world, opt, true)
    end

    on_create_supprise_video_from_world do |opt, send_now|
        output = ""
        postbox = Plugin[:gtk3].widgetof(opt.widget).widget_post
        message = postbox.buffer.text.split("\n")
        message.each do |line|
            output += line + "！（" + line + "！）\n"
        end
        output += "ﾝﾏｯ！"

        if send_now then
            world, = Plugin.filtering(:world_current, nil)
            compose(world, body:output)
            postbox.buffer.text = ""
        else
            postbox.buffer.text = output
        end
    end
end
