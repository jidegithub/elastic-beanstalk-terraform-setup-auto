<template>
  <div class="inline-block relative px-3 mb-6 md:mb-0">
    <label class="block uppercase tracking-wide text-gray-700 text-left text-xs font-bold mb-2" for="grid-city">
      Find Merchants
    </label>
    <span>
      <input v-model="searchString" v-on:input="search" class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="merchant" type="text" placeholder="search merchant">
        <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" class="search-box-icon-container" width="21" height="21" viewBox="0 0 24 24" stroke-width="2" stroke="#cbc8c8" data-icon="search" role="img" fill="none" stroke-linecap="round" stroke-linejoin="round">
          <path stroke="none" d="M0 0h24v24H0z"></path>
          <circle cx="10" cy="10" r="7"></circle>
          <line x1="21" y1="21" x2="15" y2="15"></line>
        </svg>
    </span>
  </div>
</template>

<script>
export default {
  name: 'search',
  props: { products: Array, query: String },
  data(){
    return{
      searchString: '',
      results: [],
    }
  },
  methods:{
    search(){
      this.results = this.products.filter(item => item[this.query].toLowerCase().includes(this.searchString.toLowerCase()));
      this.$emit('currentResult', this.results)
    },
  }
}
</script>

<style scoped>
  .search-box-icon-container {
    position: absolute;
    right: 25px;
    top: 40px;
    bottom: 0px;
    color: rgb(74, 85, 104);
    display: flex;
    align-items: center;
  }
</style>