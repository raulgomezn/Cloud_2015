module HomecompetitorsHelper
    def url_final(url)
        puts "------>Entró https://d2mmcudnvsg2gc.cloudfront.net/#{url}"
        return "https://d2mmcudnvsg2gc.cloudfront.net#{url}"
    end
end
