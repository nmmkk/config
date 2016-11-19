#----------------------------------------
# tmux
#----------------------------------------

# Automatic logging of tmux
# (http://d.hatena.ne.jp/q4a/20101029/1288359658)
if [ x"${TMUX}" != x"" ] ; then
    # tmux pipe-pane 'cat >> ~/log/tmux/`date +%Y-%m-%dT%H:%M:%S`_#S:#I.#P.log'
    tmux pipe-pane 'cat >> ~/log/tmux/`date +%Y-%m-%dT%H:%M:%S`_`hostname`_#S:#I.#P.log'
fi

