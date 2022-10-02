<template>
  <div class="max-w-md sm:max-w-xl lg:max-w-6xl mx-auto py-8">
    <h2 class="text-xl text-left text-gray-900">Merchants</h2>
    <section class="py-4">
      <div class="flex justify-between sm:flex-row md:flex-row flex-col -mx-3 mb-2">
        <Search query="title" :products="products" @currentResult="getResult"/>
        <div class="flex">
          <div class="px-3 mb-6 md:mb-0 w-1/2">
            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-state">
              Category
            </label>
            <div class="relative">
              <select v-model="category" @change="getFilteredData" class="block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-state">
                <option value="all">all merchant</option>
                <option value="product">product merchant</option>
                <option value="service">service merchant</option>
              </select>
              <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
              </div>
            </div>
          </div>
          <div class="px-3 mb-6 md:mb-0 w-1/2">
            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-state">
              Order
            </label>
            <div class="relative">
              <select v-model="order" @change="getFilteredData" class="block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-state">
                <option value="ascending">ascending</option>
                <option value="descending">descending</option>
              </select>
              <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <div class="flex flex-wrap mx-0 sm:-mx-4 md:-mx-4">
      <div class="mt-6 w-full px-4 lg:w-1/4 xl:w-1/4" v-for="product in filteredProducts" :key="product.id">
        <Product :product="product"/>
      </div>
    </div>
  </div>
</template>

<script>
import Product from './Product.vue';
import Search from './Search.vue';
import products from '../assets/products.json';
export default {
  name: 'products',
  components:{
    Product,
    Search
  },
  data(){
    return {
      products: products,
      filteredProducts: [],
      filteredDataBySearch: [],
      query: '',
      category: 'all',
      order: '',
      type: null,
    }
  },
  mounted() {
    this.getFilteredData();
  },
  methods:{
    getFilteredData: function() {
      this.filteredProducts = products;
      let filteredDataByfilters = [];
      // let filteredDataBySearch = [];
      this.filteredDataBySearch = [];

      // first check if filters where selected
      if (this.category !== 'all') {
        let filter = new RegExp(this.category, 'i')
        filteredDataByfilters = this.filteredProducts.filter(el => el.type.match(filter))
        this.filteredProducts = filteredDataByfilters;
      }

      if (this.order !== "") {
        this.filteredProducts.sort((a, b) =>
          this.order === "ascending"
            ? a.title > b.title
              ? 1
              : -1
            : a.title < b.title
              ? 1
              : -1
        );
      } else {
        this.filteredProducts.sort((a, b) => (a.id > b.id ? 1 : -1));
      }

      // then filter according to keyword, this only affects the title attribute of each data
      if (this.query !== '') {
        // let filter = new RegExp(this.query, 'i')
        // filteredDataBySearch = this.filteredProducts.filter(el => el.title.match(filter))
        // this.filteredProducts = filteredDataBySearch;
      }
    },
    getResult (result) {
      this.filteredDataBySearch = result
      this.filteredProducts = this.filteredDataBySearch;
    }
  },
}
</script>
