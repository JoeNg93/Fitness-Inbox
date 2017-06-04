require 'test_helper'

class ClientTest < ActiveSupport::TestCase

  def setup
    @client = Client.new(name: 'Joe', email: 'ntuandung93@gmail.com', role: 'trainer',
                         password: 'foobar', password_confirmation: 'foobar')
  end

  test 'should be valid' do
    assert @client.valid?
  end

  test 'name should be present' do
    @client.name = '     ';
    assert_not @client.valid?
  end

  test 'name should not be too long' do
    @client.name = 'a' * 100
    assert_not @client.valid?
  end

  test 'email should be present' do
    @client.email = '   '
    assert_not @client.valid?
  end

  test 'email should not be too long' do
    @client.email = "#{'a' * 102}@gmail.com"
    assert_not @client.valid?
  end

  test 'email should be downcased' do
    email = 'tEsx@gmail.com'
    @client.email = email
    @client.save
    assert_equal email.downcase, @client.email
  end

  test 'email should be uniq' do
    another_client = @client.dup
    another_client.email = @client.email.upcase
    @client.save
    assert_not another_client.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @client.email = valid_address
      assert @client.valid?
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example,
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @client.email = invalid_address
      assert_not @client.valid?
    end
  end

  test 'role should be present' do
    @client.role = '    '
    assert_not @client.valid?
  end

  test 'password should be present' do
    @client.password = ''
    @client.password_confirmation = ''
    assert_not @client.valid?
  end

  test 'password_confirmation must match password' do
    @client.password = 'testmypass'
    @client.password_confirmation = 'testmypasshehe'
    assert_not @client.valid?
  end

  test 'password_digest must appear after saved' do
    @client.save
    assert_not @client.password_digest.nil?
  end

  test 'password and password_confirmation must not appear in db' do
    @client.save
    client = Client.find_by(email: @client.email)
    assert client.password.nil? && client.password_confirmation.nil?
  end

end
