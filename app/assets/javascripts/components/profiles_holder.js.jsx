var ProfilesHolder = React.createClass({

  render: function() {

    // show message if no profiles
    if( this.props.profiles.length == 0 ) {
      return (
        <div className="col-xs-12">
          <p className="text-center find-yo-self">
            Couldn't find yourself?
            <a href="#" data-toggle="modal" data-target="#become-a-member">Become a member</a> to be added to the site!
          </p>
        </div>
      );
    }

    var profiles = this.props.profiles.map(function(profile) {
      return (<Profile key={profile.id} profile={profile} />);
    });

    return (
      <div>
        {profiles}
      </div>
    );
  }
});
