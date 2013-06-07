wpAd.config.templates = {

  //default templates
  default01: { what: ['leaderboard', 'leaderboard_2', 'leaderboard_grid', 'flex', 'flex_re', 'flex_bb_hp', 'flex_ss_bb', 'flex_ss_tp', 'flex_ss_bb_hp', '120x240', '200x50', '150x60', '285x29', 'bigbox', 'bigbox_vi', 'inline_bb*', 'itb', 'skyscraper', 'grid_bigbox*', 'persistent_bb'] },
  default02: { what: ['topjobs'], hardcode: '<script type="text/javascript" src="http://js.washingtonpost.com/wp-adv/topjobs3/top_jobs_v3.js"></script>' },
  default03: { what: ['!leaderboard'], where: ['washingtonpost.com'] },

  //define paid advertiser pushdown spot openings below this template
  subscribe_promo: {
    what: ['pushdown'],
    when: ['201301010000/201306022359'],
    where: ['washingtonpost.com'],
    hardcode: function() {
      var a = document.createElement('a'),
      i = document.createElement('img'),
      $ = window.jQuery;

      if ($) {
        //remove ad label
        $('#wpni_adi_pushdown').removeClass('slug');
      }

      a.href = 'https://account.washingtonpost.com/acquisition/?promocode=digital01&fromOverlay=1&destination&tid=signup_HP1';
      a.target = '_self';

      i.src = '//img.wpdigital.net/wp-adv/advertisers/promos/meter-promo-01-970x66.png';
      i.width = '970';
      i.height = '66';
      i.alt = 'Digital subscriptions starting at $0.99. Click here to subscribe.';
      i.style.border = '0';

      a.appendChild(i);

      return a;
    },
    test: [function() {
      //force promo for testing
      if (/show-subscribe-promo/.test(location.search)) {
        return true;
      }
      var c = wpAd.tools.getCookie('rplsb'),
      cVal = parseInt(c, 10),
      TWPVal = false,
      TWP = window.TWP || {},
      //true if in beta
      beta = window.jQuery && window.jQuery('meta[name="site-identity"]').attr('content') === 'prodportal-B';
      if (TWP && TWP.Identity && TWP.Identity.paywall && TWP.Identity.paywall.pwresp && TWP.Identity.paywall.pwresp.sub && TWP.Identity.paywall.pwresp.sub === 0) {
        TWPVal = true;
      } else {
        TWPVal = false;
      }
      //will show ONLY IF site is in beta AND the cookie exists AND the cookie is a value that is NOT 1 AND the pwresp sub value IS 0
      return beta && c && cVal !== 1 && TWPVal;
    }]
  },
  sponsor_links_bt: {
    what: ['sponsor_links_bt'],
    hardcode: function () {
      return wpAd.textlinks.init(wp_meta_data.contentType && wp_meta_data.contentType[0],"bt",commercialNode);
    },
    test: [function(){return (wpAd.tools.zoneBuilder.validate(wpAd.tools.zoneBuilder.zones.contentName()) !== "brand-connect");}]
  },
  sponsor_links_in: {
    what: ['sponsor_links_in'],
    hardcode: function(){
      return wpAd.textlinks.init(wp_meta_data.contentType && wp_meta_data.contentType[0],"in",commercialNode);
    },
    test: [function(){return (wpAd.tools.zoneBuilder.validate(wpAd.tools.zoneBuilder.zones.contentName()) !== "brand-connect");}]
  },
  sponsor_links_rr: {
    what: ['sponsor_links_rr'],
    hardcode: function(){
      return wpAd.textlinks.init(wp_meta_data.contentType && wp_meta_data.contentType[0],"rr",commercialNode);
    },
    test: [function(){return (wpAd.tools.zoneBuilder.validate(wpAd.tools.zoneBuilder.zones.contentName()) !== "brand-connect");}]
  },
  //19879-CD
  no_bb_arkadium: {
    what: ['!bigbox', 'bigbox_2'],
    where: ['entertainment/arkadium']
  },
  local_page: {
    what: ['!leaderboard','!sponsor'],
    where: ['metro/front']
  },
  //10758-HS
  trulia_bb: {
    what: ['bigbox'],
    where: ['trulia']
  },
  re_front: {
    what: ['sponsor_community'],
    where: ['realestate/front']
  },
  //henry harding and tracy sislen
  spring2013DiningGuide: {
    what: ['leaderboard*'],
    where: ['goingoutguide/restaurants/spring2013guide']
  },
  //18183-AL-251594600
  featured_agent: {
    what : ['sponsor_agent'],
    where : ['realestate/front'],
    when : ['201301110000/201312312359']
  },
  sponsor_spots_re: {
    what: ['sponsor_community','sponsor_condo','sponsor_new_home_builder'],
    where: ['realestate/neighborhoods/front', 'realestate/buy']
  },
  //20428-CD
  sponsor_spots_rentals:{
    what: ['featrent', 'featrent_2', 'featrent_3', 'featrent_4', 'featrent_5', 'featrent_6', 'featrent_7', 'featrent_8', 'featrent_9', 'featrent_10'],
    where: ['rentals']
  },
  jobs_336x60: {
    what: ['336x60'],
    where: ['jobs']
  },
  no_flex_mm: {
    what: ['!flex_ss_bb_hp'],
    where: ['multimedia/livevideo']
  },
  liveonlineflex: {
    what: ['!flex_ss_bb_hp'],
    where: ['multimedia/livevideo']
  },
  //15630-ML
  serviceAlley: {
    what: ['marketing'],
    where: ['blogs/front','local/front','local/trafficandcommuting/front','local/dc-politics/front','local/md-politics/front','local/virginia_politics/front','business/local-business/front','lifestyle/home/front','metro/front','metro/traffic','metro/dc/front','metro/md/front','metro/va/front','metro/transportation','metro/local-tools','business/localbusiness/front','artsandliving/homeandgarden/front','realestate','realestate/neighborhoods/front','rentals'],
    hardcode: '<script type="text/javascript" src="http://www.servicealley.com/javascripts/wapo-widget.js"></script>'
  },
  gog_deal: {
    what: ['deal'],
    where: ['metro/front','cityguide'],
    hardcode: function(){
      var a = {"metro":"11","artsandliving/foodanddining":"12","cityguide":"13","cityguide/restaurants":"14","cityguide/bars":"15","cityguide/movies":"16","cityguide/events":"17","cityguide/music":"18","cityguide/museums":"19","cityguide/theater":"20","cityguide/bestbets":"21","cityguide/kidfriendly":"22","cityguide/visitors":"23"};
      return a[commercialNode] ? '<script type="text/javascript" src="http://files.secondstreetmedia.com/washingtonpost/widget'+a[commercialNode]+'.js"></script>' : '';
    }
  },
  local_food_336x60: {
    what: ['336x60'],
    where: ['lifestyle/food/front','local/front'],
    hardcode: function(){
      var a = {"local/front":"11","lifestyle/food/front":"12"};
      return a[commercialNode] ? '<script type="text/javascript" src="http://files.secondstreetmedia.com/washingtonpost/widget'+a[commercialNode]+'.js"></script>' : '';
    }
  },
  serviceAlley_test: {
    what: ['marketing'],
    where: ['blogs/front','local/front','local/trafficandcommuting/front','local/dc-politics/front','local/md-politics/front','local/virginia_politics/front','business/local-business/front','lifestyle/home/front','lifestyle/home_garden','metro/front','metro/traffic','metro/dc/front','metro/md/front','metro/va/front','metro/transportation','metro/local-tools','business/localbusiness/front','artsandliving/homeandgarden/front','realestate','realestate/neighborhoods/front','rentals'],
    hardcode: /http\:\/\/qaprev\./.test(location.href) ?
      (!window.jQuery ? '<sc' + 'ript type="text/javascript" src="http://js.washingtonpost.com/wpost/js/combo?token=20120507181000&c=true&m=true&context=eidos&r=/jquery-1.4.js"></sc' + 'ript>' : '' )+'<sc' + 'ript type="text/javascript" src="http://bunsen.wapolabs.com/revplat/prod/1.4.5-3/js/revplat.wp-config.js"></sc' + 'ript><sc' + 'ript type="text/javascript" src="http://bunsen.wapolabs.com/revplat/prod/1.4.5-3/js/revplat.min.js"></sc' + 'ript><div id="rev_ad_6"></div>' :
      '<sc'+'ript type="text/javascript" src="http://www.servicealley.com/javascripts/wapo-widget.js"></scr'+'ipt>'
  },
  ups_no_inline_bb: {
    what: ['!inline_bb'],
    where: ['liveonline/viewpoint/nevellj']
  },
  //18875-CD
  re300x100: {
    what: ['300x100'],
    where: ['realestate']
  },
  //RICH P
  test_lep: {
    what: ['600x130'],
    where: ['jobs/front']
  },
  agoogleadaytest: {
    what: ['agoogleaday'],
    url_check: ['test_ads=agoogleaday']
  },
  networknews_test: {
    url_check: ['test_ads=networknews'],
    what: ['nn_hp'],
    hardcode: '<div id="nn_ad_tile_hp" style="background-color: rgb(153, 153, 153); position: relative; padding: 0px; margin: 0px; height: 20px; width: 190px;"><img src="http://www.washingtonpost.com/wp-srv/images/spacer.gif" width="190" height="20"><div style="position: absolute; top: 5px; left: 5px; color: rgb(255, 255, 255); font-size: 12px; font-family: Arial,Helvetica,sans-serif;">190x20 Test Spot<br></div></div>'
  },
  liveslostgallery: {
    what : ['!nav_tile', '!tiffany_tile', '!leaderboard', '!extra_bb', '!leaderboard_2', '!bigbox', '!promo'],
    page_id: ['1000.1.3877687284']
  },
  //18182-AL-235419621
  lf336: {
    what: ['336x35_top'],
    where: ['realestate/front'],
    when: ['201301010000/201312312359']
  },
  //20406-LB
  moneygrab: {
    what: ['extra_bb'],
    test: [function(){ return (/compoundstory/i.test(wpAd.tools.zoneBuilder.getString(wp_meta_data.contentType))) ? true : false; }]
  },
  //20552-CD
  car_dealer_showcase: {
    'what': ['dealer_showcase', 'dealer_showcase_2', 'dealer_showcase_3'],
    'where': ['cars/front']
  },
  //99999-JH
  custom_magazine: {
    what: ['marketing_2'],
    where: ['lifestyle/magazine/front'],
    when: ['201304140000/201305182359'],
    hardcode: '<a href="http://www.washingtonpost.com/wp-adv/post-hunt/video/" target="_blank"><img src="http://www.washingtonpost.com/wp-adv/tiles/magazine/huntvideotile.png" width="300" height="250" border="0" alt="Check Out Our Video!" style="display:block"/></a><a href="http://www.washingtonpost.com/wp-adv/2013/privateschools" target="_blank"><img src="http://img.wpdigital.net/wp-adv/2013/privateschools/tiles/privateschoolstile3.300x250.3.jpg" width="300" height="250" border="0" alt="Click Here for More!" style="display:block;margin-top:10px;"/></a>'
  },
  //99999-JH
  custom_magazine_2: {
    what: ['marketing_2'],
    where: ['lifestyle/magazine/front'],
    when: ['201305190000/201312312359'],
    hardcode: '<a href="http://www.washingtonpost.com/wp-adv/post-hunt/video/" target="_blank"><img src="http://www.washingtonpost.com/wp-adv/tiles/magazine/huntvideotile.png" width="300" height="250" border="0" alt="Check Out Our Video!" style="display:block"/></a><a href="http://www.washingtonpost.com/wp-adv/2013/capitalcuisine/" target="_blank"><img src="http://img.wpdigital.net/wp-adv/2013/magazine/tiles/2013springdiningtile.300x250.png" width="300" height="250" border="0" alt="Click Here for More!" style="display:block;margin-top:10px;"/></a>'
  },
  //21169-CD
  ing_tile: {
    what: ['88x31'],
    when: ['201304010000/201306302359']
  },
  //21219-CD
  carr_homes: {
    what: ['sponsor_new_home_builder'],
    where: ['realestate'],
    when: ['201304080000/201309302359']
  },
  //GOG-RESPONSIVE
  gog_responsive: {
    what: ['!flex_bb_hp'],
    where: ['cityguide/restaurants'],
    test: [function(){ return (document.documentElement.clientWidth < 1024) ? true : false; }]
  },
  //21181-JH
  crowdsourced: {
    what: ['marketing'],
    where: ['business'],
    hardcode: function(){
      var smallBusiness = /^business\/on\-small\-business/.test(commercialNode),
        imgBase = 'http://img.wpdigital.net/wp-adv/advertisers/crowdsourced/img/',
        src = smallBusiness ? 'CrowdSourced_201304_300x100_01.png' : 'CrowdSourced_201304_300x100_02.png',
        url = smallBusiness ? 'http://www.washingtonpost.com/business/on-small-business/small-business-success-how-to-take-your-company-online/3582e0d8-9871-11e2-b68f-dc5c4b47e519_topic.html' :
            'http://www.washingtonpost.com/business/capitalbusiness/a-game-changer-for-career-advancement-and-job-placement/82c377bc-9728-11e2-b68f-dc5c4b47e519_topic.html',
        img = document.createElement('img'),
        a = document.createElement('a');

      img.src = imgBase + src;
      img.width = '300';
      img.height = '100';
      img.style.border = '0';
      img.alt = 'Click here for more information';

      a.target = '_self';
      a.href = url;
      a.appendChild(img);

      if($){
        //then need to move further up right rail:
        $(function(){
          var $target = smallBusiness ? $('#slug_pptile') : $('#rev_ad_8').prev();
          //prevent a second placeAd2 call executing
          $('#slug_marketing script').remove();
          if($target.length){
            $target.after($('#slug_marketing'));
          }
        });
      }

      return a;
    }
  }
};

wpAd.config.adtypes = {
  "120x240": { "size": [[120,240]], "keyvalues": { "ad": ["120x240"] } },
  "300x100": { "size": [[300,100]] },
  "336x35": { "size": [[336,35]], "keyvalues": { "ad": ["336x35"], "pos": ["ad19"] } },
  "336x35_top": { "size": [[336,35]], "keyvalues": { "ad": ["336x35"] } },
  "336x60": { "size": [[336,60]], "keyvalues": { "ad": ["336x60"] } },
  "200x50": { "size": [[200,50]], "keyvalues": { "ad": ["200x50"] } },
  "150x60": { "size": [[150,60]], "keyvalues": { "ad": ["150x60"] } },
  "285x29": { "size": [[285,29]], "keyvalues": { "ad": ["285x29"] } },
  "600x130": { "size": [[600,130]] },
  "88x31": { "size": [[88,31]] },
  "agoogleaday": { "size": [[1,1]] },
  "bigbox": { "size": [[300,250]], "keyvalues": { "ad": ["bb"], "pos": ["ad20"] } },
  "deal": { "size": [[1,1]], "keyvalues": { "ad": ["deal"], "pos": ["ad45"] } },
  "dealer_showcase": { "size": [[1,1]] },
  "extra_bb": { "size": [[300,250]], "keyvalues": { "ad": ["bb"], "pos": ["ad44"] } },
  "featrent": { "size": [[1,1]] },
  "featurebar": { "size": [[446,33]], "keyvalues": { "ad": ["fb"], "pos": ["ad7"] } },
  "flex": { "size": [[336,850]], "keyvalues": { "ad": ["hp"] } },
  "flex_bb_hp": { "size": [[300,250],[300,600],[336,850]], "keyvalues": { "ad": ["hp","bb"], "pos": ["ad16"] } },
  "flex_re": { "size": [[300,250],[300,600]], "keyvalues": { "ad": ["bb","tp"] } },
  "flex_ss_bb": { "size": [[160,600],[300,250]], "keyvalues": { "ad": ["ss","bb"] } },
  "flex_ss_bb_hp": { "size": [[160,600],[300,250],[300,600],[336,850]], "keyvalues": { "ad": ["ss","bb","hp"], "pos": ["ad6"] } },
  "flex_ss_tp": { "size": [[300,250],[300,600]], "keyvalues": { "ad": ["bb","tp"] } },
  "grid_bigbox":  { "size": [[300,250]] },
  "inline_bb": { "size": [[300,250]], "keyvalues": { "ad": ["inline_bb"] } },
  "itb": { "size": [[1,1]] },
  "leaderboard": { "size": [[728,90]], "keyvalues": { "ad": ["lb"], "pos": ["ad1"] } },
  "leaderboard_2": { "size": [[728,90]], "keyvalues": { "ad": ["lb"], "pos": ["ad2"] } },
  "leaderboard_grid": { "size": [[728,90]] },
  "marketing": { "size": [[1,1]] },
  "mm_overlay": { "size": [[1,1]] },
  "nav_tile": { "size": [[1,1]] },
  "navtile": { "size": [[200, 60]]},
  "nn": { "size": [[200,80]] },
  "nn_footer": { "size": [[200,30]], "keyvalues": { "ad": ["nn_footer"] } },
  "nn_hp": { "size": [[190,20]], "keyvalues": { "ad": ["nn_hp"] } },
  "nn_rr": { "size": [[200,80]], "keyvalues": { "ad": ["nn_rr"] } },
  "nn_sidebar": { "size": [[200,30]], "keyvalues": { "ad": ["nn_sidebar"] } },
  "persistent_bb": { "size": [[300,250]] },
  "pptile": { "size": [[300,60]] },
  "promo": { "size": [[200,60]] },
  "pushdown": { "size": [[1,1]], "keyvalues": { "pos": ["ad43"] } },
  "skyscraper": { "size": [[160,600]], "keyvalues": { "ad": ["ss"], "pos": ["ad3"] } },
  "sponsor": { "size": [[1,1]] },
  "sponsor_links_bt": { "size": [[1,1]] },
  "sponsor_links_in": { "size": [[1,1]] },
  "sponsor_links_rr": { "size": [[1,1]] },
  "tiffany_tile": { "size": [[200,60]], "keyvalues": { "ad": ["tiff"], "pos": ["ad14"] } },
  "tooltile": { "size": [[1,1]] },
  "topjobs": { "size": [[1,1]] }
};
