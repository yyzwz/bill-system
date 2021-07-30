const CompressionPlugin = require('compression-webpack-plugin');

module.exports = {
    devServer: {
        host: 'localhost',
        port: 8080,
        proxy: {
            '/xboot': {
                target: 'http://127.0.0.1:1314',
                ws: true
            },
            '/foo': {
                target: '<other_url>'
            }
        }
    },
    productionSourceMap: false,
    configureWebpack: {
        externals: {
            vue: 'Vue',
            'vue-i18n': 'VueI18n',
            axios: 'axios',
            'vue-router': 'VueRouter',
            vuex: 'Vuex',
            'view-design': 'iview',
            echarts: 'echarts',
            apexcharts: 'ApexCharts',
            'vue-apexcharts': 'VueApexCharts',
            xlsx: 'XLSX',
            dplayer: 'DPlayer',
            'print-js': 'printJS',
            html2canvas: 'html2canvas',
            'vue-json-pretty': 'VueJsonPretty',
            'vue-lazyload': 'VueLazyload',
            gitalk: 'Gitalk',
            'js-cookie': 'Cookies',
            wangEditor: 'wangEditor',
            quill: 'Quill',
            'sockjs-client': 'SockJS',
            vuedraggable: 'vuedraggable',
            viewerjs: 'Viewer'
        },
        // GZIP压缩
        plugins: [
            new CompressionPlugin({
                test: /\.js$|\.html$|\.css/, // 匹配文件
                threshold: 10240 // 对超过10k文件压缩
            })
        ]
    }
}