var Profile = React.createClass({

  render: function() {

    return (
      <div className="col-md-3 col-sm-4">
        <div className="profile-thumb" style={{backgroundImage: 'url(' + this.props.profile.avatar_url + ')'}}>
          <div className="profile-info">
            <div className="profile-desc ">
              <a href={"https://github.com/" + this.props.profile.username} target="_blank" className="username">@{this.props.profile.username}</a>
              <span className="company">{this.props.profile.company}</span>
              <span className="joined-github">joined Github over 4 years ago</span>
            </div>
          </div>
        </div>
      </div>
    );
  }
});