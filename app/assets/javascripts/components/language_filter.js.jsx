var LanguageFilter = React.createClass({

  changeLanguage: function(event) {
    this.props.onChange(event.target.value)
  },

  render: function() {


    // todo: language selected
    // todo: (<%= language.profiles.count %>)

    var languageOptions = this.props.languages.map(function(language) {
      return (
        <option key={language.id} value={language.slug}>
          {language.name}
        </option>
      );
    })

    // onChange="javascript:this.form.submit();"

    return (
      <div className="col-sm-3">
        <div className="language-filter">

          <select name="language" className="form-control" value={this.props.selectedLanguage} onChange={this.changeLanguage}>
            <option value="">All Languages ({this.props.profilesAllCount} devs)</option>
            {languageOptions}
          </select>

        </div>
      </div>
    );
  }
});
