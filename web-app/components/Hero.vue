<template>
<section class="pt-4 max-w-md mx-auto sm:max-w-xl lg:max-w-full">
  <div class="">
    <carousel :scrollPerPage="true" :perPage=1 :navigationEnabled="true" :paginationEnabled="false">
      <slide v-for="slide in slides" :key="slide">
        <img :src="slide" :alt="slide">
      </slide>
    </carousel>
  </div>
</section>
  
</template>

<script lang="ts">
import Slider from './Slider.vue';
// import Carousel from './carousel/Carousel.vue';
import CarouselSlide from './carousel/CarouselSlide.vue';
import { Carousel, Slide } from 'vue-carousel';
export default {
  name: 'hero',
  components: {
    Slider,
    // Carousel: Carousel,
    CarouselSlide: CarouselSlide,
    Carousel,
    Slide
  },
  data(){
    return{
      slides: [
        'https://picsum.photos/id/230/600/300',
        'https://picsum.photos/id/231/600/300',
        'https://picsum.photos/id/232/600/300',
        'https://picsum.photos/id/233/600/300',
        'https://picsum.photos/id/234/600/300',
        'https://picsum.photos/id/235/600/300',
        'https://picsum.photos/id/236/600/300',
      ]
    }
  }
}
</script>

<style>
  div .VueCarousel-slide{
    width: 10rem;
    /* height: 100%; */
  }
  /* .VueCarousel-slide{
    width: 900px;
    height: 500px;
  } */

  img{
    width:100%;
    height: 100%;
  }
  .carousel-cont {
    display:flex;
    justify-content: center;
  }
  .carousel {
    position:relative;
    overflow: hidden;
    /* width:800px; */
    width: 1151px;
    height:500px;
    z-index:10;
  }
  .btns {
    padding:5px 10px;
    background-color:rgba(0,0,0,0.5);
    border:1px solid transparent;
    margin:5px 10px;
    color:#FFF;
    height:50px;
    width:50px;
    position:absolute;
    margin-top:-25px;
    z-index:2;
  }
  .btns:hover {
    cursor: pointer;
  }
  .btns:focus{
    outline:none;
  }
  .btns-next {
    top:50%;
    right:0;
  }
  .btns-prev {
    top:50%;
    left:0;
  }
  .carousel-slider {
    position:absolute;
    top:0;
    left:0;
    bottom:0;
    right:0;
  }
  .carousel-slider img {
    width:100%;
    height:100%;
  }
</style>