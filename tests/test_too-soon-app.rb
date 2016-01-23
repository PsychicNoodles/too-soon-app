require "./lib/too-soon-app"
require "test/unit"

class SequelTestCase < Test::Unit::TestCase
  def run(*args, &block)
    Sequel::Model.db.transaction(:rollback=>:always, :auto_savepoint=>true){super}
  end

  def test_password_confirmation
    psyndl = User.new :username => 'psyndl', :email => 'jerry@kasigh.com', :password => 'asdf', :password_confirmation => 'qwer'
    assert(!psyndl.valid?)
    psyndl.password_confirmation = 'asdf'
    assert(psyndl.valid?)
    assert_not_nil(psyndl.authenticate('asdf'))
    assert_nil(psyndl.authenticate('qwer'))
  end

  def test_topic_modifiers
    undertale = Topic.new :name => 'Undertale'
    undertale.save
    themovie = Modifier.new :name => 'the Movie'
    themovie.save
    thevideogame = Modifier.new :name => 'the Video Game'
    thevideogame.save
    undertale.add_modifier(themovie)
    undertale.add_modifier(thevideogame)
    undertale.add_modifier(:name => 'the Sequel')
    thesequel = Modifier.find(:name => 'the Sequel')
    assert_equal(Set.new([themovie, thevideogame, thesequel]), Set.new(undertale.modifiers))
  end

  def test_user_vote
    psyndl = User.new :username => 'psyndl', :email => 'jerry@kasigh.com', :password => 'asdf', :password_confirmation => 'asdf'
    psyndl.save
    undertale = Topic.new :name => 'Undertale'
    undertale.save
    vote = Vote.new :vote => true, :topic => undertale, :user => psyndl
    vote.save
    assert_not_nil(vote.datetime)
  end

  def test_vote_modifiers
    psyndl = User.new :username => 'psyndl', :email => 'jerry@kasigh.com', :password => 'asdf', :password_confirmation => 'asdf'
    psyndl.save
    undertale = Topic.new :name => 'Undertale'
    undertale.save
    themovie = Modifier.new :name => 'the Movie', :topic => undertale
    themovie.save
    thevideogame = Modifier.new :name => 'the Video Game', :topic => undertale
    thevideogame.save
    vote = Vote.new :vote => true, :topic => undertale, :user => psyndl
    vote.save
    vote.add_modifier thevideogame
    vote.add_modifier themovie
    assert_equal(Set.new([themovie, thevideogame]), Set.new(vote.modifiers))
  end
end
