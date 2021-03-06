require 'puppet/util/pidlock'

# This module is responsible for encapsulating the logic for
#  "locking" the puppet agent during a run; in other words,
#  keeping track of enough state to answer the question
#  "is there a puppet agent currently running?"
#
# The implementation involves writing a lockfile whose contents
#  are simply the PID of the running agent process.  This is
#  considered part of the public Puppet API because it used
#  by external tools such as mcollective.
#
# For more information, please see docs on the website.
#  http://links.puppetlabs.com/agent_lockfiles
module Puppet::Agent::Locker
  # Yield if we get a lock, else do nothing.  Return
  # true/false depending on whether we get the lock.
  def lock
    if lockfile.lock
      begin
        yield
      ensure
        lockfile.unlock
      end
    end
  end

  def running?
    lockfile.locked?
  end

  def lockfile
    @lockfile ||= Puppet::Util::Pidlock.new(Puppet[:agent_pidfile])

    @lockfile
  end
  private :lockfile


end
