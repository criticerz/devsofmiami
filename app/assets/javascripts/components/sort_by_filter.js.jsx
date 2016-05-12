var SortByFilter = React.createClass({

  changeSortBy: function(event) {
    var sortBy = event.target.value;

    if( this.props.sortBy != sortBy )
      this.props.onSortByChange(event.target.value);
  },
  changeOrder: function(order) {
    if( this.props.sortByOrder != order )
      this.props.onSortByOrderChange(order);
  },

  render: function() {

    return (
      <div className="col-sm-5">

        <div className="sort-by-filter">

          <select name="sort_by" className="form-control" value={this.props.sortBy} onChange={this.changeSortBy}>
            <option value="">Public Activity</option>
            <option value="github-joined">Joined Github</option>
            <option value="github-followers">Github Followers</option>
          </select>

          <div className="btn-group" data-toggle="buttons">
            <label className={'btn btn-sm btn-default desc ' + (this.props.sortByOrder == 'desc' ? 'active' : '')} onClick={this.changeOrder.bind(this, 'desc')}>
              <input type="radio" name="sort_order" defaultValue="desc" defaultChecked={this.props.sortByOrder == 'desc'} /> DESC
            </label>
            <label className={'btn btn-sm btn-default asc ' + (this.props.sortByOrder == 'asc' ? 'active' : '')} onClick={this.changeOrder.bind(this, 'asc')}>
              <input type="radio" name="sort_order" defaultValue="asc" defaultChecked={this.props.sortByOrder == 'asc'} /> ASC
            </label>
          </div>

        </div>

      </div>
    );
  }
});
