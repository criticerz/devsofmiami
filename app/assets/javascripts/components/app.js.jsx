var App = React.createClass({

  // value="<%= params[:username] %>"

  // <%= will_paginate @profiles %>

  getInitialState: function() {
    return {
      selectedLanguage: '',
      sortBy: '',
      sortByOrder: 'desc',
      loadingState: true,
      profiles: [],
      searchUsername: undefined
    }
  },

  // LanguageFilter functions
  handleLanguageFilterChange: function(newLanguage) {
    this.setState({
      selectedLanguage: newLanguage,
      searchUsername: ''
    }, function() {
      this.loadProfiles();
    });
  },

  // SortByFilter functions
  handleSortByChange: function(sortBy) {
    this.setState({
      sortBy: sortBy,
      searchUsername: ''
    }, function() {
      this.loadProfiles();
    });
  },
  handleSortOrderByChange: function(sortByOrder) {
    this.setState({
      sortByOrder: sortByOrder,
      searchUsername: ''
    }, function() {
      this.loadProfiles();
    });
  },
  searchByUsername: function(username) {
    this.setState({
      searchUsername: username,
      selectedLanguage: '',
      sortBy: '',
      sortByOrder: 'desc'
    }, function() {
      this.loadProfiles();
    });
  },

  loadProfiles: function() {

    var _this = this;

    this.setState({ loadingState: true });

    var data = {
      language: this.state.selectedLanguage,
      sort_by: this.state.sortBy,
      sort_order: this.state.sortByOrder,
      username: this.state.searchUsername
    };

    $.ajax({
      type: 'GET',
      url: '/profiles.json',
      dataType: 'json',
      data: data
    }).done(function(data){

      _this.setState({ profiles: data.profiles, loadingState: false })

    }).error(function(error) {

      console.log(error);

    })

  },

  componentDidMount: function() {

    this.loadProfiles();

  },

  render: function() {

    if( this.state.loadingState ) {
      var profilesArea = <div>Loading...</div>;
    } else {
      var profilesArea = <ProfilesHolder profiles={this.state.profiles}/>;
    }

    return (
      <div className="container-fluid">

        <div className="row filter-container">

          <form action="/" method="get" className="filters hidden-xs">

            <LanguageFilter
              onChange={this.handleLanguageFilterChange}
              selectedLanguage={this.state.selectedLanguage}
              languages={this.props.languages}
              profilesAllCount={this.props.profilesAllCount} />

            <SortByFilter
              onSortByChange={this.handleSortByChange}
              onSortByOrderChange={this.handleSortOrderByChange}
              sortBy={this.state.sortBy}
              sortByOrder={this.state.sortByOrder} />

          </form>

          <form action="/" method="get" className="filters">

            <SearchBar searchUsername={this.state.searchUsername} onChange={this.searchByUsername} />

          </form>

        </div>

        <div className="row">
          {profilesArea}
        </div>

        <div className="row">
          <div className="col-xs-12 profile-pagination">
          </div>
        </div>

      </div>
    );
  }
});
