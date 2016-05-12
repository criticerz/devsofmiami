var SearchBar = React.createClass({

  searchByUsername: function(event) {
    this.props.onChange(event.target.value);
  },

  render: function() {
    return (
      <div className="col-sm-4">
        <div className="search-by-username">
          <input
            type="text"
            name="username"
            placeholder="Search by Github username"
            className="form-control"
            value={this.props.searchUsername}
            onChange={this.searchByUsername} />
        </div>
      </div>
    );
  }
});
